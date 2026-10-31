import { useState } from 'react'
import classesData from '../shared/classes.json'
import type { ClassInfo, UserProfile } from '../shared/types'

const CLASSES: ClassInfo[] = classesData.classes

function App() {
  const [selectedClass, setSelectedClass] = useState<ClassInfo | null>(null)
  const [selectedSpec, setSelectedSpec] = useState<string | null>(null)
  const [activeProfileId, setActiveProfileId] = useState<string | null>(null)
  const [profiles, setProfiles] = useState<UserProfile[]>([])

  // Load profiles from localStorage on mount
  if (profiles.length === 0) {
    try {
      const stored = localStorage.getItem('cap_profiles')
      if (stored) {
        setProfiles(JSON.parse(stored))
      }
    } catch {
      // Ignore parse errors
    }
  }

  const handleClassSelect = (classInfo: ClassInfo) => {
    setSelectedClass(classInfo)
    setSelectedSpec(null)
  }

  const handleSpecSelect = (specId: string) => {
    setSelectedSpec(specId)
  }

  const activeProfile = profiles.find(p => p.id === activeProfileId) || null

  return (
    <div style={{ display: 'flex', height: '100vh', fontFamily: 'sans-serif' }}>
      {/* Class list sidebar */}
      <div style={{
        width: 240,
        borderRight: '1px solid #334155',
        padding: '16px 0',
        overflowY: 'auto',
      }}>
        <h2 style={{ padding: '0 16px 12px', fontSize: 16, color: '#e94560' }}>
          Class Addon Picker
        </h2>
        {CLASSES.map(cls => (
          <div
            key={cls.id}
            onClick={() => handleClassSelect(cls)}
            style={{
              padding: '8px 16px',
              cursor: 'pointer',
              background: selectedClass?.id === cls.id ? '#334155' : 'transparent',
              display: 'flex',
              alignItems: 'center',
              gap: 8,
            }}
          >
            <span style={{
              width: 20,
              height: 20,
              borderRadius: '50%',
              background: '#e94560',
              display: 'inline-block',
            }} />
            {cls.name}
          </div>
        ))}
      </div>

      {/* Main content */}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
        {/* Spec tabs */}
        {selectedClass && (
          <div style={{
            display: 'flex',
            gap: 0,
            borderBottom: '1px solid #334155',
          }}>
            {selectedClass.specs.map(spec => (
              <button
                key={spec.id}
                onClick={() => handleSpecSelect(spec.id)}
                style={{
                  padding: '12px 24px',
                  cursor: 'pointer',
                  border: 'none',
                  borderBottom: selectedSpec === spec.id ? '3px solid #e94560' : '3px solid transparent',
                  background: selectedSpec === spec.id ? '#1e293b' : 'transparent',
                  color: selectedSpec === spec.id ? '#e94560' : '#94a3b8',
                  fontWeight: selectedSpec === spec.id ? 700 : 400,
                }}
              >
                {spec.name}
              </button>
            ))}
          </div>
        )}

        {/* Recommendation list */}
        <div style={{ flex: 1, padding: 24, overflowY: 'auto' }}>
          {!selectedClass && <p style={{ color: '#94a3b8' }}>Select a class to see recommendations.</p>}
          {selectedClass && !selectedSpec && <p style={{ color: '#94a3b8' }}>Select a spec above.</p>}

          {selectedClass && selectedSpec && (
            <div>
              <h3 style={{ marginBottom: 16, fontSize: 18 }}>
                Recommended Addons for {selectedClass.name} — {
                  selectedClass.specs.find(s => s.id === selectedSpec)?.name
                }
              </h3>

              {/* Essential addons */}
              <div style={{ marginBottom: 24 }}>
                <h4 style={{ color: '#ef4444', fontSize: 14, textTransform: 'uppercase', letterSpacing: 1 }}>
                  Essential
                </h4>
                <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
                  {RECOMMENDATIONS[selectedClass.id + '_' + selectedSpec]
                    ?.filter(r => r.priority === 'essential')
                    .map(addon => (
                      <AddonCard key={addon.key} addon={addon} activeProfileId={activeProfileId} />
                    )) || [
                      // Default shared essentials shown when no spec-specific data exists
                      { key: 'dbm', name: 'Deadly Boss Mods', priority: 'essential' as const, description: 'Essential raid boss addon.', url: '#' },
                      { key: 'weakauras', name: 'WeakAuras', priority: 'essential' as const, description: 'Powerful aura tracker.', url: '#' },
                    ]
                  }
                </div>
              </div>

              {/* Recommended */}
              <div style={{ marginBottom: 24 }}>
                <h4 style={{ color: '#f59e0b', fontSize: 14, textTransform: 'uppercase', letterSpacing: 1 }}>
                  Recommended
                </h4>
                <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
                  {RECOMMENDATIONS[selectedClass.id + '_' + selectedSpec]
                    ?.filter(r => r.priority === 'recommended')
                    .map(addon => (
                      <AddonCard key={addon.key} addon={addon} activeProfileId={activeProfileId} />
                    )) || []}
                </div>
              </div>

              {/* Optional */}
              <div>
                <h4 style={{ color: '#3b82f6', fontSize: 14, textTransform: 'uppercase', letterSpacing: 1 }}>
                  Optional
                </h4>
                <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
                  {RECOMMENDATIONS[selectedClass.id + '_' + selectedSpec]
                    ?.filter(r => r.priority === 'optional')
                    .map(addon => (
                      <AddonCard key={addon.key} addon={addon} activeProfileId={activeProfileId} />
                    )) || []}
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Profile bar */}
        <ProfileBar profiles={profiles} activeProfileId={activeProfileId} onActivate={setActiveProfileId} />
      </div>
    </div>
  )
}

// Default recommendation data (matches shared/addon-recommendations.ts)
const RECOMMENDATIONS: Record<string, Array<{ key: string; name: string; priority: 'essential' | 'recommended' | 'optional'; description: string; url?: string }>> = {}

function AddonCard({ addon, activeProfileId }: { addon: typeof RECOMMENDATIONS[string][number]; activeProfileId: string | null }) {
  const isChecked = activeProfileId !== null // simplified — in reality this checks if the addon is in the profile
  return (
    <div style={{
      display: 'flex',
      alignItems: 'center',
      gap: 12,
      padding: '8px 12px',
      background: '#0f3460',
      borderRadius: 6,
      cursor: 'pointer',
    }}>
      <input type="checkbox" checked={isChecked} readOnly style={{ accentColor: '#e94560' }} />
      <div>
        <div style={{ fontWeight: 600 }}>{addon.name}</div>
        <div style={{ fontSize: 12, color: '#94a3b8' }}>{addon.description}</div>
      </div>
      {addon.url && (
        <a href={addon.url} target="_blank" rel="noreferrer" style={{ marginLeft: 'auto', fontSize: 12, color: '#e94560' }}>
          ↗ Download
        </a>
      )}
    </div>
  )
}

function ProfileBar({ profiles, activeProfileId, onActivate }: {
  profiles: UserProfile[]
  activeProfileId: string | null
  onActivate: (id: string | null) => void
}) {
  return (
    <div style={{
      padding: '8px 24px',
      borderTop: '1px solid #334155',
      background: '#16213e',
      display: 'flex',
      alignItems: 'center',
      gap: 12,
    }}>
      <span style={{ fontSize: 13, color: '#94a3b8' }}>Active profile:</span>
      {profiles.length === 0 ? (
        <span style={{ fontSize: 13, color: '#64748b' }}>None</span>
      ) : (
        profiles.map(p => (
          <button
            key={p.id}
            onClick={() => onActivate(activeProfileId === p.id ? null : p.id)}
            style={{
              padding: '4px 12px',
      border: activeProfileId === p.id ? '1px solid #e94560' : '1px solid #334155',
      background: activeProfileId === p.id ? '#e94560' : 'transparent',
      color: activeProfileId === p.id ? '#fff' : '#94a3b8',
      borderRadius: 4,
      cursor: 'pointer',
            }}
          >
            {p.name}
          </button>
        ))
      )}
      <span style={{ marginLeft: 'auto', fontSize: 12, color: '#64748b' }}>
        {profiles.length} saved profile{profiles.length !== 1 ? 's' : ''}
      </span>
    </div>
  )
}

export default App
